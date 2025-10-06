
#include "MainWindow.h"
#include "moc_MainWindow.cpp"
#include "ui_MainWindow.h"
#include "QGVScene.h"
#include "QGVNode.h"
#include "QGVEdge.h"
#include "QGVSubGraph.h"
#include <QMessageBox>
#include <QFileDialog>
#include <QString>
extern std::string extractDotString(std::string fileName);
MainWindow::MainWindow(QWidget *parent) :
    QMainWindow(parent),
    ui(new Ui::MainWindow)
{
    ui->setupUi(this);
    QFileDialog dialog(this);
    dialog.setFileMode(QFileDialog::AnyFile);
    dialog.setNameFilter(tr("Verilog \\ SystemVerilog (*.v *.sv )"));
    dialog.setViewMode(QFileDialog::Detail);
    QStringList fileNames;
    if (dialog.exec())
        fileNames = dialog.selectedFiles();
    analyzed_file = fileNames.first();
    _scene = new QGVScene("DEMO", this);

}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::drawGraph()
{
    std::string extractedDFile = extractDotString(analyzed_file.toStdString());
    _scene->loadLayout(QString(extractedDFile.c_str()));
    ui->graphicsView->setScene(_scene);
    ui->graphicsView->setViewportUpdateMode(QGraphicsView::FullViewportUpdate );
    ui->graphicsView->viewport()->update();

    return;
}

