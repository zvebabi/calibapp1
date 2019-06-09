#ifndef ANALIZERCDC_H
#define ANALIZERCDC_H

#include <QtCore/QObject>
#include <QVariant>
#include <QVector>
#include <QSerialPort>
#include <QSerialPortInfo>
#include <QStringList>
#include <QByteArray>
#include <QPointF>
#include <QAbstractSeries>
#include <QtCharts/QAbstractSeries>
#include <QtCharts/QXYSeries>
#include <QColor>
#include <QVariantList>
#include <QStringList>
#include <QDebug>
#include <QDir>
#include <QPair>
#include <QFile>
#include <vector>
#include <fstream>
#include <typeinfo>
#include <iostream>
#include <fstream>
#include <sstream>
#include <ctime>
#include <memory>
#include <thread>

#include "statistic.h"

class uartReader : public QObject
{
    Q_OBJECT
public:
    explicit uartReader(QObject *parent = 0);
    ~uartReader();
public slots:
    void initDevice(QString port, QString baudRate,
                    QVariantList propertiesNames_,
                    QVariantList propertiesValues_);
    void updateProperties(QVariantList propertiesNames_,
                          QVariantList propertiesValues_);
    void getListOfPort();
    void readProperties();
    void readTempsProperties(bool mV);

    QString getDataPath() {return documentsPath;}
    void readData();
    void prepareCommandToSend(QString cmd_);
    void setHistoryView(QString timeWidth){
        m_nSecs = int(timeWidth.toDouble()*3600.0);
    }
    void clearAllData();
    void writeToFileOne(bool mode, QString _temp, QString _conc, QString fn1){
        m_writeToFileOne = mode;
        m_currentTemp = _temp;//.toDouble();
        m_currentConc = _conc;//.toDouble();
        m_filenameOne = fn1;
    }
    void enableLogging(QString _nSamples, QString _logDelay);
    void disableLogging();
    void logToFile2();

    void sendSeriesPointer(QtCharts::QAbstractSeries *series_,
                           QtCharts::QAbstractAxis *Xaxis_);
    void selectPath(QString pathForSave);

signals:
    void sendPortName(QString port);
    void sendProperties(QVariantList propertiesValues_);
    void sendTemperatures(QVariantList temperatureValues_);

    void sendDebugInfo(QString data, int time=700);
    void sendSerialNumber(QString serNumber);
    void makeSeries(); // run 1 time on startup
    void disableButton();
    void adjustAxis(QPointF axisYRange_Umeas
                   ,QPointF axisYRange_Uref
                   ,QPointF axisYRange_Upn
                   ,QPointF axisYRange_C);
    void sendDataToUI(QPointF _mean
                     ,QPointF _ref
                     ,QPointF _pn);
private:
    void sendDataToDevice();
    QVector<QVector<QPointF>> allDataHere;
    QVector<QVector<QPointF>> dataForLogging;
    QVector<QPointF> tempPoint;  //0-meas
                                 //1-ref
                                 //2-pn
                                 //3-C,
    QVector<QPointF> axisYRange; //x-min, y - max
    void update(int graphIdx, QPointF p);
    void processLine(const QByteArray& line);
    void serviceModeHandler(const QStringList& line);
    void identityHandler(const QStringList& line);
    void dataAquisitionHandler(const QStringList& line);
    void dataProcessingHandler(QVector<QPointF> tempPoint);
    void processTemppoint(int num, double value);
    void buttonPressHandler(const QStringList& line);
    void calcMeanDev(std::vector<Statistics<double> > &data, int numOfSamples);

    std::vector<QString> ports;

    QSerialPort* device = NULL;
    QVector<QtCharts::QAbstractSeries *>m_series;
    QVector<QtCharts::QAbstractAxis *>m_axisX;
    int m_serNumber;
    int m_nSamples;
    int m_nSecs;
    QString m_currentTemp;
    QString m_currentConc;
    QString m_filenameOne;
    int m_logWriteDelay;
    int m_nSamplesLog;
    std::shared_ptr<QTimer> timer;
    bool m_writeToFileOne, m_enableLogging;
    std::shared_ptr<QFile> logFile;
    bool isPortOpen, firstLine, serviceMode;
    std::atomic_bool deviceInSleepMode;
    QVector<QString> m_queueCommandsToSend;

    QString documentsPath;
    std::ofstream diagnosticLog;

    QVariantList currentProperties;

};

#endif // ANALIZERCDC_H
