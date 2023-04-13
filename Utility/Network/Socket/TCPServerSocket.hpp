#pragma once

#include <QTcpSocket>
#include <QTcpServer>

namespace utility::network::socket
{

class TCPServerSocket : public QObject
{
    Q_OBJECT

public:
    explicit TCPServerSocket(QObject *parent = nullptr);
    ~TCPServerSocket();

    bool startServer(int port);
    void stopServer();

signals:
    void clientConnected(QTcpSocket *socket);
    void clientDisconnected(QTcpSocket *socket);
    void clientDataReceived(QTcpSocket *socket, const QByteArray &data);

private slots:
    void onNewConnection();
    void onClientDisconnected();
    void onReadyRead();

private:
    QTcpServer m_server;
    QList<QTcpSocket*> m_clientList;
};

}
