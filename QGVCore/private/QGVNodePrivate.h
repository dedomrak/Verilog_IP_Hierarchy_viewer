#ifndef QGVNODEPRIVATE_H
#define QGVNODEPRIVATE_H

#include <cgraph.h>

class QGVNodePrivate
{
public:
    QGVNodePrivate(Agnode_t *node, Agraph_t *parent/*,char *label*/);

    void setNode(Agnode_t *node);
    Agnode_t* node() const;
    
    Agraph_t* graph() const;

private:
    Agnode_t* _node;
    Agraph_t* _parent;
   // char * _label;
};

#endif // QGVNODEPRIVATE_H
