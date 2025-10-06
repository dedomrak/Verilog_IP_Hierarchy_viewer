TEMPLATE = subdirs

CONFIG += ordered

SUBDIRS += QGVCore
SUBDIRS += VIPH_viewer
SUBDIRS += veri_test

win32:CONFIG(release, debug|release): LIBS += -L'C:/Program Files/Graphviz/lib/' -lcdt
else:win32:CONFIG(debug, debug|release): LIBS += -L'C:/Program Files/Graphviz/lib/' -lcdtd
else:unix: LIBS += -L'C:/Program Files/Graphviz/lib/' -lcdt

INCLUDEPATH += 'C:/Program Files/Graphviz/include'
DEPENDPATH += 'C:/Program Files/Graphviz/include'

win32:CONFIG(release, debug|release): LIBS += -L'C:/Program Files/Graphviz/lib/' -lgvc
else:win32:CONFIG(debug, debug|release): LIBS += -L'C:/Program Files/Graphviz/lib/' -lgvcd
else:unix: LIBS += -L'C:/Program Files/Graphviz/lib/' -lgvc

INCLUDEPATH += 'C:/Program Files/Graphviz/include'
DEPENDPATH += 'C:/Program Files/Graphviz/include'

win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += 'C:/Program Files/Graphviz/lib/libgvc.a'
else:win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += 'C:/Program Files/Graphviz/lib/libgvcd.a'
else:win32:!win32-g++:CONFIG(release, debug|release): PRE_TARGETDEPS += 'C:/Program Files/Graphviz/lib/gvc.lib'
else:win32:!win32-g++:CONFIG(debug, debug|release): PRE_TARGETDEPS += 'C:/Program Files/Graphviz/lib/gvcd.lib'
else:unix: PRE_TARGETDEPS += 'C:/Program Files/Graphviz/lib/libgvc.a'
