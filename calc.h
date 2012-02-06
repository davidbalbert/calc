typedef enum { typeCon, typeId, typeOpr } nodeEnum;

// constants
typedef struct {
        int value;
} conNodeType;

// identifiers
typedef struct {
        int i; // index in sym[]
} idNodeType;

// operators
typedef struct {
        int opr;        // operator
        int nops;       // number of operands
        struct nodeTypeTag **op; // operands
} oprNodeType;

typedef struct nodeTypeTag {
        nodeEnum type;

        union {
                conNodeType con;
                idNodeType id;
                oprNodeType opr;
        };
} nodeType;

extern int sym[26];
