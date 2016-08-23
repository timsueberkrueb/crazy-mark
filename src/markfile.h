#ifndef MARKFILE_H
#define MARKFILE_H

#include <QObject>
#include <QUrl>
#include <QFile>
#include <QTextStream>
#include <QFileInfo>

class MarkFile : public QObject
{
    Q_OBJECT

    Q_PROPERTY(QUrl url READ getUrl WRITE setUrl NOTIFY urlChanged)
    Q_PROPERTY(QString fileName READ getFileName WRITE setFileName NOTIFY fileNameChanged)
public:
    explicit MarkFile(QObject *parent = 0);

    QUrl getUrl() const { return m_url; }
    void setUrl(QUrl url) { m_url = url; emit urlChanged(url); }

    QString getFileName() const { return m_fileName; }
    void setFileName(QString fileName) { m_fileName = fileName; emit fileNameChanged(fileName); }

    Q_INVOKABLE QString read();
    Q_INVOKABLE void write(QString text);

private:
    QUrl m_url;
    QString m_fileName;

signals:
    void urlChanged(QUrl url);
    void fileNameChanged(QString fileName);

public slots:
};

#endif // MARKFILE_H
