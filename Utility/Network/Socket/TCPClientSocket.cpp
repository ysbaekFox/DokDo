#include "TCPClientSocket.hpp"

using namespace utility::network::socket;

TCPClientSocket::TCPClientSocket(QObject *parent)
    : QObject(parent)
{
    connect(&m_client, &QTcpSocket::connected, this, &TCPClientSocket::onClientConnected);
    connect(&m_client, &QTcpSocket::disconnected, this, &TCPClientSocket::onClientDisconnected);
    connect(&m_client, &QTcpSocket::errorOccurred, this, &TCPClientSocket::onClientErrorOccurred);
}

TCPClientSocket::~TCPClientSocket()
{
}

void TCPClientSocket::connectToServer(const QString& host, const quint16 port)
{
    qDebug() << "TCPClientSocket::connectToServer:" << host << ", port:" << port;
    m_client.connectToHost(host, port);
}

void TCPClientSocket::disconnectFromServer()
{
    qDebug() << "TCPClientSocket::disconnectFromServer";
    m_client.disconnectFromHost();
}

void TCPClientSocket::sendMessage(const QString& message)
{
    qDebug() << "TCPClientSocket::sendMessage:" << message;
    m_client.write(message.toUtf8());
}

void TCPClientSocket::onClientConnected()
{
    qDebug() << "TCPClientSocket::connected";
}

void TCPClientSocket::onClientDisconnected()
{
    qDebug() << "TCPClientSocket::onClientDisconnected";
}

void TCPClientSocket::onClientErrorOccurred(QAbstractSocket::SocketError socketError)
{
    qDebug() << "TCPClientSocket::onClientErrorOccurred";
}
