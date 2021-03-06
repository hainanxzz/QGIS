/** A composer items that draws common shapes (ellipse, triangle, rectangle)*/
class QgsComposerShape: QgsComposerItem
{
%TypeHeaderCode
#include "qgscomposershape.h"
%End
  public:

    enum Shape
    {
      Ellipse,
      Rectangle,
      Triangle
    };

    QgsComposerShape( QgsComposition* composition /TransferThis/ );
    QgsComposerShape( qreal x, qreal y, qreal width, qreal height, QgsComposition* composition /TransferThis/);
    ~QgsComposerShape();

    /** Return correct graphics item type. Added in v1.7 */
    virtual int type() const;

    /** \brief Reimplementation of QCanvasItem::paint - draw on canvas */
    void paint( QPainter* painter, const QStyleOptionGraphicsItem* itemStyle, QWidget* pWidget );

    /** Stores state in Dom element
     * @param elem is Dom element corresponding to 'Composer' tag
     * @param doc write template file
     */
    bool writeXml( QDomElement& elem, QDomDocument & doc ) const;

    /** Sets state from Dom document
     * @param itemElem is Dom node corresponding to item tag
     * @param doc is Dom document
     */
    bool readXml( const QDomElement& itemElem, const QDomDocument& doc );

    //setters and getters
    QgsComposerShape::Shape shapeType() const;
    void setShapeType( QgsComposerShape::Shape s );

    /** Sets radius for rounded rectangle corners. Added in 2.1 */
    void setCornerRadius( double radius );
    /** Returns the radius for rounded rectangle corners*/
    double cornerRadius() const;

    /** Sets the QgsFillSymbol used to draw the shape. Must also call setUseSymbol( true ) to
     * enable drawing with a symbol.
     * Note: added in version 2.1*/
    void setShapeStyleSymbol( QgsFillSymbol* symbol );
    /** Returns the QgsFillSymbol used to draw the shape.
     * Note: added in version 2.1*/
    QgsFillSymbol* shapeStyleSymbol();

    /** Controls whether the shape should be drawn using a QgsFillSymbol.
     * Note: Added in 2.1 */
    void setUseSymbol( bool useSymbol );

    /** Depending on the symbol style, the bounding rectangle can be larger than the shape
    @note this function was added in version 2.3*/
    QRectF boundingRect() const;

    /** Sets new scene rectangle bounds and recalculates hight and extent. Reimplemented from
     * QgsComposerItem as it needs to call updateBoundingRect after the shape's size changes
     */
    void setSceneRect( const QRectF& rectangle );

    //Overridden to return shape type
    virtual QString displayName() const;

  protected:
    /* reimplement drawFrame, since it's not a rect, but a custom shape */
    virtual void drawFrame( QPainter* p );
    /* reimplement drawBackground, since it's not a rect, but a custom shape */
    virtual void drawBackground( QPainter* p );
    /** Reimplement estimatedFrameBleed, since frames on shapes are drawn using symbology
     * rather than the item's pen */
    virtual double estimatedFrameBleed() const;

  public slots:
    /** Should be called after the shape's symbol is changed. Redraws the shape and recalculates
     * its selection bounds.
     * Note: added in version 2.1*/
    void refreshSymbol();
};
