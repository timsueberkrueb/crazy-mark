#include "palette.h"
#include <QVariant>

Palette::Palette()
{

}

Palette::Palette(QObject *helper)
{
    setHelper(helper);
}

void Palette::setHelper(QObject *helper){
    m_helper = helper;
    red = helper->property("red").value<QColor>();
    green = helper->property("green").value<QColor>();
    orange = helper->property("orange").value<QColor>();
    purple = helper->property("purple").value<QColor>();
    blue = helper->property("blue").value<QColor>();
    darkGrey = helper->property("darkGrey").value<QColor>();
    midGrey = helper->property("midGrey").value<QColor>();
    lightGrey = helper->property("lightGrey").value<QColor>();
}
