#ifndef PALETTE_H
#define PALETTE_H

#include <QObject>
#include <QColor>

class Palette
{
public:
    Palette();
    Palette(QObject *helper);

    void setHelper(QObject *helper);

    QColor red;
    QColor green;
    QColor orange;
    QColor purple;
    QColor blue;
    QColor darkGrey;
    QColor midGrey;
    QColor lightGrey;

private:
    QObject *m_helper;

signals:

public slots:
};

#endif // PALETTE_H
