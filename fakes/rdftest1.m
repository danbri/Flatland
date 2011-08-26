
# Messing around with squeezing RDF into matlab/octave...
#
# All of this is wrong. Better to check out sql/rdf and prolog prior work.
#
# (and see also the struct datastructure...?)

# a purely text view, not used here
A = { 	'http://alice' 'foaf:name' 'Alice' 'L' 'en' ;
 	'http://bob' 'foaf:knows' 'http://alice' 'T' '';	
	'http://bob' 'foaf:age'	'30' 'DL' 'xsd:int';
	'http://alice' 'foaf:gender' 'female' 'L' '' ;
	'http://bob' 'foaf:gender' 'male' 'L' '' ;
	};

# e.g. see http://blogs.mathworks.com/loren/2006/06/21/cell-arrays-and-their-contents/

# unsustainable but for proof of concept:
DICT =  { 
	1 'http://alice';
	2 'http://bob';
	3 'foaf:name';
	4 'Alice';
	5 'foaf:knows';
	6 'foaf:gender';
	7 'foaf:age';
	8 '30';
	9 'Bob';
	10 'male';
	11 'female';
	};

CLAIM = [ 
	1 3 4 ;
	2 5 1 ;
	2 7 8 ;
	1 6 11 ;	
	2 6 10 ;
    ];

# CLAIM1 = CLAIM2 = CLAIM3 = CLAIM4 = CLAIM5 = CLAIM;

# DICT

# convenience aliases
SUB=1
PRED=2
OBJ=3

# excerpts from main dict (yes, they overlap with the above)
ALICE=1
BOB=2
KNOWS=5
GENDER=6
AGE=7


a1 = find( CLAIM(:,PRED) == GENDER ); # find triples with 'gender'

disp("\n");
for I=1:length(a1)
  IX=a1(I); # I'th result
  disp(sprintf("Result %i matched triple no %i: ",I,IX))
  sub_id = B(IX,1);
  pred_id = B(IX,2);
  obj_id = B(IX,3);
  # disp(sprintf("s/p/o %i %i %i ",  sub_id, pred_id, obj_id  ))
  disp(sprintf("s/p/o %s %s %s ",  DICT{sub_id,2}, DICT{pred_id,2}, DICT{obj_id,2} ))
  disp("\n");
end



a2 = ( find ( CLAIM(:,SUB)==BOB & CLAIM(:,OBJ)==ALICE ))

disp("\n");
for I=1:length(a2)
  IX=a2(I); # I'th result
  disp(sprintf("Result %i matched triple no %i: ",I,IX))
  sub_id = B(IX,1);
  pred_id = B(IX,2);
  obj_id = B(IX,3);
  # disp(sprintf("s/p/o %i %i %i ",  sub_id, pred_id, obj_id  ))
  disp(sprintf("s/p/o %s %s %s ",  DICT{sub_id,2}, DICT{pred_id,2}, DICT{obj_id,2} ))
  disp("\n");
end


# s/p/o http://bob foaf:knows http://alice 

# (none of this is abstracted into a function, because none of it is right yet...)
