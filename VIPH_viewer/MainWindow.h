#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
#include "QGVScene.h"

namespace Ui {
class MainWindow;
}

class MainWindow : public QMainWindow
{
    Q_OBJECT
    
public:
    explicit MainWindow(QWidget *parent = 0);
    ~MainWindow();
    void drawGraph();
    void FitAndChangeShapeToRect();

private slots:


public:
    Ui::MainWindow *ui;
    QGVScene *_scene;
    QString analyzed_file;
};

#endif // MAINWINDOW_H
