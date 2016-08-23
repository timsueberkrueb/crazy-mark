#include "markfile.h"

MarkFile::MarkFile(QObject *parent) : QObject(parent)
{

}

QString MarkFile::read()
{
    QFile file(m_url.toLocalFile());

    if (!file.open(QFile::ReadOnly))
        return "";

    // Set fileName
    setFileName(QFileInfo(file).baseName());

    return QString(file.readAll());
}

void MarkFile::write(QString text)
{
    QFile file(m_url.toLocalFile());

    if (!file.open(QFile::WriteOnly | QIODevice::Text))
        return;

    QTextStream stream(&file);
    stream << text << endl;
}
