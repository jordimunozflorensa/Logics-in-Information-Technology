#include <iostream>
#include <stdlib.h>
#include <algorithm>
#include <vector>
#include <cmath>
#include <unordered_map>
using namespace std;

#define UNDEF -1
#define TRUE 1
#define FALSE 0

uint numVars;
uint conflictes;
uint numClauses;
vector<vector<int> > clauses;
unordered_map<int, pair<vector<int>, vector<int>>> ocur_list; // first -> positivas, second -> negativas
vector<int> model; // foto de l'estat de les variables (1,-1, 0)
vector<int> modelStack; //  solució parcial, p. ex: 0 1 2 0 3 4 -7
uint indexOfNextLitToPropagate; // punter al modelStack
uint decisionLevel; // numero de decisions

vector<int> num_colisions; 

/*
  - HEURÍSTICA ESTÀTICA: agafar la variable indefinida que es trobi en mes clausules
  - HEURÍSTICA DINÀMICA: - un contador per cada variable, que s'incrementa cada cop que la variable apareix en una clàusula on hi ha conflicte
                         - es triarà la variable que tingui el contador més alt
                         - ens interessen més els conflictes més recents (++contador)
                              - dividirem (experimentar la constant del quocient) el contador cada cert temps (cada x numero de conflictes) del contador de cada variable
*/
/*
  RAND 3-CNF
  - Si la relació entre el num variables i el numero de clàusules, i les clasules es generen aleatoriament,
    si es < 4.25 casi sempre seran SATISFACTIBLES, else INSATISFACTIBLE
*/

void intialize() {
  for (int i = 0; i < int(numVars); ++i) {
    ocur_list.emplace(i + 1, make_pair<vector<int>, vector<int>> (vector<int>(), vector<int>()));
    num_colisions[i + 1] = 0;
  }
}

void readClauses( ){
  // Skip comments
  char c = cin.get();
  while (c == 'c') {
    while (c != '\n') c = cin.get();
    c = cin.get();
  }  
  // Read "cnf numVars numClauses"
  string aux;
  cin >> aux >> numVars >> numClauses;
  clauses.resize(numClauses);
  num_colisions.resize(numVars+1);
  intialize();
  // Read clauses
  for (uint i = 0; i < numClauses; ++i) {
    int lit;
    while (cin >> lit and lit != 0) {
      ++num_colisions[abs(lit)];
      clauses[i].push_back(lit);

      if (lit > 0) ocur_list[lit].first.push_back(i);
      else ocur_list[-lit].second.push_back(i);
    }
  }    
}


int currentValueInModel(int lit){
  if (lit >= 0) return model[lit];
  else {
    if (model[-lit] == UNDEF) return UNDEF;
    else return 1 - model[-lit];
  }
}


void setLiteralToTrue(int lit){
  modelStack.push_back(lit);
  if (lit > 0) model[lit] = TRUE;
  else model[-lit] = FALSE;		
}


bool propagateGivesConflict ( ) {
  while ( indexOfNextLitToPropagate < modelStack.size() ) {
    int lit = modelStack[indexOfNextLitToPropagate];
    ++indexOfNextLitToPropagate;

    vector<int> list;
    if (lit > 0) list = ocur_list[lit].second;
    else list = ocur_list[-lit].first;
    
    for (uint i = 0; i < list.size(); ++i) {
      bool someLitTrue = false;
      int numUndefs = 0;
      int lastLitUndef = 0;
      for (uint k = 0; not someLitTrue and k < clauses[list[i]].size(); ++k) {
        int val = currentValueInModel(clauses[list[i]][k]);
        if (val == TRUE) someLitTrue = true;
        else if (val == UNDEF){ ++numUndefs; lastLitUndef =  clauses[list[i]][k];} 
      }

      if (not someLitTrue and numUndefs == 0) {
        for (uint row = 0; row < numClauses; ++row) {
          for (uint col = 0; col < clauses[0].size(); ++col) {
            
            if (abs(clauses[row][col]) == abs(lit)) {
              for (uint c = 0; c < clauses[0].size(); ++c) {
                num_colisions[abs(clauses[row][c])] += numClauses;
              }
            } 
          }
        }
        ++conflictes;
        if (conflictes%1000 == 0) {
          for (int i = 0; i < int(numVars); ++i) {
            num_colisions[i] *= 0.5;
          }
        }
        return true; // conflict! all lits false
      }
      else if (not someLitTrue and numUndefs == 1) setLiteralToTrue(lastLitUndef);	
    }
  }
  return false;
}


void backtrack(){
  uint i = modelStack.size() -1;
  int lit = 0;
  while (modelStack[i] != 0){ // 0 is the DL mark
    lit = modelStack[i];
    model[abs(lit)] = UNDEF;
    modelStack.pop_back();
    --i;
  }
  // at this point, lit is the last decision
  modelStack.pop_back(); // remove the DL mark
  --decisionLevel;
  indexOfNextLitToPropagate = modelStack.size();
  setLiteralToTrue(-lit);  // reverse last decision
}


 // Heuristic for finding the next decision literal:
int getNextDecisionLiteral_STATIC() {
  int max = 0;
  int max_size = 0;
  for (const auto& l : ocur_list) {
    int key = l.first;
    int size = l.second.first.size() + l.second.second.size();

    if (model[abs(key)] == UNDEF && size > max_size) {
      max = key;
      max_size = size;
    }
  }
  return max; // returns the key with the largest vector<int> size
}

// Heuristic for finding the next decision literal:
int getNextDecisionLiteral_DINAMICA() {
  int max = 0;
  int num_ocur = 0;
  for (uint i = 1; i < num_colisions.size(); ++i) {
    if (model[i] == UNDEF && num_colisions[i] > num_ocur) {
      num_ocur = num_colisions[i];
      max = i;
    }
  }
  return max; // returns the key with the largest vector<int> size
}

void checkmodel(){
  for (uint i = 0; i < numClauses; ++i){
    bool someTrue = false;
    for (uint j = 0; not someTrue and j < clauses[i].size(); ++j)
      someTrue = (currentValueInModel(clauses[i][j]) == TRUE);
    if (not someTrue) {
      cout << "Error in model, clause is not satisfied:";
      for (uint j = 0; j < clauses[i].size(); ++j) cout << clauses[i][j] << " ";
      cout << endl;
      exit(1);
    }
  }  
}

int main(){ 
  readClauses(); // reads numVars, numClauses and clauses
  model.resize(numVars+1,UNDEF);
  indexOfNextLitToPropagate = 0;  
  decisionLevel = 0;
  conflictes = 0;
  
  // Take care of initial unit clauses, if any
  for (uint i = 0; i < numClauses; ++i)
    if (clauses[i].size() == 1) {
      int lit = clauses[i][0];
      int val = currentValueInModel(lit);
      if (val == FALSE) {cout << "UNSATISFIABLE" << endl; return 10;}
      else if (val == UNDEF) setLiteralToTrue(lit);
    }
  
  // DPLL algorithm
  while (true) {
    while ( propagateGivesConflict() ) {
      if ( decisionLevel == 0) { cout << "UNSATISFIABLE" << endl; return 10; }
      backtrack();
    }
    /* int decisionLit = getNextDecisionLiteral_DINAMICA(); */
    int decisionLit = 0;
    if (conflictes > 1000) decisionLit = getNextDecisionLiteral_DINAMICA();
    else decisionLit = getNextDecisionLiteral_STATIC();

    if (decisionLit == 0) { checkmodel(); cout << "SATISFIABLE" << endl; return 20; }
    // start new decision level:
    modelStack.push_back(0);  // push mark indicating new DL
    ++indexOfNextLitToPropagate;
    ++decisionLevel;
    setLiteralToTrue(decisionLit);    // now push decisionLit on top of the mark
  }
}