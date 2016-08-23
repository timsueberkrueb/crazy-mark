#ifndef DESKTOPFILEDIALOG_H
#define DESKTOPFILEDIALOG_H

#include <QObject>
#include <QFile>
#include <QFileDialog>
#include <QStandardPaths>
#include <QUrl>
#include <QTextStream>


class DesktopFileDialog : public QObject
{
    Q_OBJECT
public:
    explicit DesktopFileDialog(QObject *parent = 0);

    Q_INVOKABLE QString askOpenFile();
    Q_INVOKABLE QString askOpenFileText();

    Q_INVOKABLE QString askSaveFile();
    Q_INVOKABLE QString askSaveFileText(QString text);

signals:

public slots:
};

#endif // DESKTOPFILEDIALOG_H
