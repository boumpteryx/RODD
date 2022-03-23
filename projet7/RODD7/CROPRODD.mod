int NbParcelles =...; //nombre de parcelles
range Parcelles =1..NbParcelles;
int T =...; //horizon de planification
range Periode=1..T;
int SURF=...;
int lmax= ...; // duree au-delà de laquelle prolonger la jachère n'améliore plus le rendement'
int amax= ...; //nombre max de de semestres de cultures
{int} C[1..2] = ...; //cultures en semestre pair/impair

int s[t in Periode]=(t%2==1)?1:2;

{int} Cultures=C[1] union C[2];

 int Demande[Cultures][Periode]=...;
 
 tuple sommet{
 int l; //age de la jachere
 int a; // age de la culture
 int j; //culture ou jachere en cours 
 }
 
 {sommet} Sommets=...;
 
 tuple arc {
sommet i; //extremite initiale
sommet f; //extremite finale
int rend;
}  
 
 {arc} Arcs=...;
 {arc} InitArc=
 {<<2,0,0>,<2,0,0>,0>,
 <<2,0,0>,<2,1,1>,120>
 };
 
 dvar boolean x[Arcs][Periode][Parcelles];
 
 minimize sum( p in Parcelles, u in InitArc) x[u][1][p];
 
subject to {
  forall(p in Parcelles){
        sum(u in Arcs : u in InitArc) x[u][1][p] <= 1; // le flot est de maximum 1 par parcelle
        sum(u in Arcs : u not in InitArc) x[u][1][p] == 0 ; // ne pas passer par les arcs qui n'existent pas
      }
  forall(t in Periode){
    forall(c in C[s[t]]){
      sum(p in Parcelles) sum(u in Arcs : u.f.j == c) x[u][t][p]*u.rend >= Demande[c][t]; // satisfaction de la demande
    }
  }
  forall(sommet in Sommets){
    forall(p in Parcelles){
      forall(t in 1..T-1){
        sum(u in Arcs : u.i == sommet) x[u][t+1][p] == sum(u in Arcs : u.f == sommet) x[u][t][p] ; // conservation du flot
      }
    }
  }
}
