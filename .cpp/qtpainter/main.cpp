/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:BSD$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** BSD License Usage
** Alternatively, you may use this file under the terms of the BSD license
** as follows:
**
** "Redistribution and use in source and binary forms, with or without
** modification, are permitted provided that the following conditions are
** met:
**   * Redistributions of source code must retain the above copyright
**     notice, this list of conditions and the following disclaimer.
**   * Redistributions in binary form must reproduce the above copyright
**     notice, this list of conditions and the following disclaimer in
**     the documentation and/or other materials provided with the
**     distribution.
**   * Neither the name of The Qt Company Ltd nor the names of its
**     contributors may be used to endorse or promote products derived
**     from this software without specific prior written permission.
**
**
** THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
** "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
** LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
** A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
** OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
** SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
** LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
** DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
** THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
** (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
** OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE."
**
** $QT_END_LICENSE$
**
****************************************************************************/

#include <QApplication>
#include <QTimer>
#include <QPainter>
#include <QWidget>


class PaintWidget : public QWidget
{
   // Q_OBJECT

public:
    PaintWidget(QWidget *parent = nullptr) : QWidget(parent)
    {
        floatBased = false;
        antialiased = false;
        frameNo = 0;

        setBackgroundRole(QPalette::Base);
        setSizePolicy(QSizePolicy::Expanding, QSizePolicy::Expanding);

        QTimer *timer = new QTimer(this);
        connect(timer, &QTimer::timeout, this, &PaintWidget::nextAnimationFrame);
        timer->start(100);
    }

    virtual ~PaintWidget() override
    {

    }

    void setFloatBased(bool floatBased)
    {
        this->floatBased = floatBased;
        update();
    }
    void setAntialiased(bool antialiased)
    {
        this->antialiased = antialiased;
        update();
    }

    QSize minimumSizeHint() const override
    {
        return QSize(640, 480);
    }
    QSize sizeHint() const override
    {
        return QSize(640, 480);
    }

public slots:
    void nextAnimationFrame()
    {
        ++frameNo;
        update();
    }

protected:
    void paintEvent(QPaintEvent *event) override
    {
        QPainter painter(this);
        painter.setRenderHint(QPainter::Antialiasing, antialiased);
        painter.translate(width() / 2, height() / 2);
    //! [6]

    //! [7]
        for (int diameter = 0; diameter < 256; diameter += 9)
        {
            int delta = abs((frameNo % 128) - diameter / 2);
            int alpha = 255 - (delta * delta) / 4 - diameter;
    //! [7] //! [8]
            if (alpha > 0)
            {
                painter.setPen(QPen(QColor(0, diameter / 2, 127, alpha), 3));

                if (floatBased)
                    painter.drawEllipse(QRectF(-diameter / 2.0, -diameter / 2.0, diameter, diameter));
                else
                    painter.drawEllipse(QRect(-diameter / 2, -diameter / 2, diameter, diameter));
            }
        }


    }

private:
    int  frameNo;
    bool floatBased;
    bool antialiased;
};

int main(int argc, char *argv[])
{
    QApplication app(argc, argv);

    PaintWidget C;
    C.setFloatBased(true);
    C.setAntialiased(true);
    C.show();

    return app.exec();
}
