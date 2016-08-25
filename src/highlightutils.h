#ifndef HIGHLIGHTUTILS_H
#define HIGHLIGHTUTILS_H

#include <QObject>
#include <QQuickTextDocument>
#include <QTextDocument>
#include "markhighlighter.h"
#include "palette.h"

class HighlightUtils : public QObject
{
    Q_OBJECT
public:
    explicit HighlightUtils(Palette Palette, QObject *parent = 0);

    Q_INVOKABLE void installHighlighter(QQuickTextDocument* doc);

private:
    Palette m_palette;

signals:

public slots:
};

#endif // HIGHLIGHTUTILS_H
