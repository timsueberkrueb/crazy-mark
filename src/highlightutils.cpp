#include "highlightutils.h"

HighlightUtils::HighlightUtils(Palette palette, QObject *parent) : QObject(parent)
{
    m_palette = palette;
}

void HighlightUtils::installHighlighter(QQuickTextDocument *doc)
{
    new MarkHighlighter(m_palette, doc->textDocument());
}

