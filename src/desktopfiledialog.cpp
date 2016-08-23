#include "desktopfiledialog.h"

DesktopFileDialog::DesktopFileDialog(QObject *parent) : QObject(parent)
{

}

QString DesktopFileDialog::askOpenFile()
{
    return QFileDialog::getOpenFileName(
            0,
            ("Open File"),
            QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation),
            ("Markdown Files (*.md *.markdown *.mdown *.mkdn *.mkd *.mdwn *.mdtxt *.mdtext *.text)")
    );

}

QString DesktopFileDialog::askOpenFileText()
{
    QString filename = askOpenFile();
    QFile file(filename);
    if (!file.open(QFile::ReadOnly))
        return "";
    QString text = file.readAll();

    file.close();
    return text;
}

QString DesktopFileDialog::askSaveFile()
{
    return QFileDialog::getSaveFileName(
            0,
            ("Save File"),
            QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation),
            ("Markdown Files (*.md *.markdown *.mdown *.mkdn *.mkd *.mdwn *.mdtxt *.mdtext *.text)")
    );

}

QString DesktopFileDialog::askSaveFileText(QString text)
{
    QString fileName = askSaveFile();
    if (fileName == "")
        return "";
    QFile file(fileName);
    if (!file.open(QFile::WriteOnly | QIODevice::Text))
        return "";
    QTextStream stream;
    stream << text << endl;
    return fileName;
}

