#include "QGVNodePrivate.h"
#include <QString>

QGVNodePrivate::QGVNodePrivate(Agnode_t *node, Agraph_t *parent/*,char *label*/) :
    _node(node), _parent(parent)/*, _label(label)*/
{
}

void QGVNodePrivate::setNode(Agnode_t *node)
{
   // agset(node, "label", agstrdup_html( graph(),_label));
    _node = node;
  //  agset(_node, "label", agstrdup_html( graph(),_label));
}

Agnode_t* QGVNodePrivate::node() const
{
    return _node;
}

Agraph_t* QGVNodePrivate::graph() const
{
    return _parent;
}
