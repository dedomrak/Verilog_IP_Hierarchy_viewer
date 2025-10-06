#-------------------------------------------------
#
# Project created by QtCreator 2013-04-17T09:06:06
#
#-------------------------------------------------

QT       += core

greaterThan(QT_MAJOR_VERSION, 4){
    QT += widgets
}
lessThan(QT_MAJOR_VERSION, 5) {
    QT += gui
}

TARGET = QGVCore
TEMPLATE = lib
CONFIG += shared

DESTDIR = ../lib
DLLDESTDIR = ../bin

#GraphViz librairie
!include(GraphViz.pri) {
     error("fail open GraphViz.pri")
 }

SOURCES += QGVScene.cpp \
    QGVNode.cpp \
    QGVEdge.cpp \
    QGVSubGraph.cpp \
		private/QGVCore.cpp \
		private/QGVGraphPrivate.cpp \
		private/QGVGvcPrivate.cpp \
		private/QGVEdgePrivate.cpp \
		private/QGVNodePrivate.cpp

HEADERS  += QGVScene.h \
    QGVNode.h \
    QGVEdge.h \
    QGVSubGraph.h \
		private/QGVCore.h \
		private/QGVGraphPrivate.h \
		private/QGVGvcPrivate.h \
		private/QGVEdgePrivate.h \
		private/QGVNodePrivate.h \
    qgv.h

win32:CONFIG(release, debug|release): LIBS += -L'C:/Program Files/Graphviz/lib/' -lgvc
else:unix: LIBS += -L'C:/Program Files/Graphviz/lib/' -lgvc

INCLUDEPATH += 'C:/Program Files/Graphviz/include'
DEPENDPATH += 'C:/Program Files/Graphviz/include'

win32:CONFIG(release, debug|release): LIBS += -L'C:/Program Files/Graphviz/lib/' -lgvc
#else:win32:CONFIG(debug, debug|release): LIBS += -L'C:/Program Files/Graphviz/lib/' -lgvcd

INCLUDEPATH += 'C:/Program Files/Graphviz/include'
DEPENDPATH += 'C:/Program Files/Graphviz/include'
