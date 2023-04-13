#pragma once

#include <QTcpSocket>

namespace utility::network::socket
{

class TCPClientSocket : public QObject
{
    Q_OBJECT

public:
    explicit TCPClientSocket(QObject *parent = nullptr);
    ~TCPClientSocket();

    void connectToServer(const QString& host, const quint16 port);
    void disconnectFromServer();
    void sendMessage(const QString& message);

public slots:
    void onClientConnected();
    void onClientDisconnected();
    void onClientErrorOccurred(QAbstractSocket::SocketError socketError);

private:
    QTcpSocket m_client;
};

}
