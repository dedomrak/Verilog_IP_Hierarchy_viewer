QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = VIPH_viewer
TEMPLATE = app

DESTDIR = ../bin

#QGVCore library
LIBS += -L$$OUT_PWD/../lib -lQGVCore
INCLUDEPATH += $$PWD/../QGVCore
DEPENDPATH += $$PWD/../QGVCore

#GraphViz library
!include(../QGVCore/GraphViz.pri) {
     error("fail open GraphViz.pri")
 }

SOURCES += main.cpp\
    MainWindow.cpp \
    QGraphicsViewEc.cpp

HEADERS  += MainWindow.h \
     QGraphicsViewEc.h

FORMS    += MainWindow.ui

RESOURCES += \
    ress.qrc

win32:CONFIG(release, debug|release): LIBS += -L'C:/Program Files/Graphviz/lib/' -lcdt
else:unix: LIBS += -L'C:/Program Files/Graphviz/lib/' -lcdt

INCLUDEPATH += 'C:/Program Files/Graphviz/include'
DEPENDPATH += 'C:/Program Files/Graphviz/include'

win32: LIBS += -L$$PWD/../lib/ -lveri_test

INCLUDEPATH += $$PWD/../
DEPENDPATH += $$PWD/../
