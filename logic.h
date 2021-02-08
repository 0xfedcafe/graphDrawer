#ifndef LOGIC_H
#define LOGIC_H

#include <QtQml/qqml.h>
#include <QtQml/qqmlapplicationengine.h>

#include <QObject>
#include <QQmlComponent>
#include <QString>
#include <tuple>
#include <unordered_set>
#include <utility>
#include <vector>

#include "vertex.h"
#include "vertice.h"
class Logic : public QObject {
  Q_OBJECT
  Q_PROPERTY(std::vector<Vertex*> adjacency_list_ READ adjacency_list WRITE
                 SetAdjacencyList)
  QML_ELEMENT
 public:
  Logic();
 public slots:
  Q_INVOKABLE void HandleClick(int a, int b);
  Q_INVOKABLE void HandleRelease();
  Q_INVOKABLE void HandleHold(int a, int b);
  Q_INVOKABLE void HandleDelete();
  Q_INVOKABLE Vertice NewVertice(uint8_t x, uint8_t y);
  Q_INVOKABLE bool HandlingSubfunc(Vertice clicked);
  std::vector<Vertex*> adjacency_list() { return adjacency_list_; }
  void SetAdjacencyList(std::vector<Vertex*> v) { adjacency_list_ = v; }

 private:
  std::vector<Vertex*> adjacency_list_;
  std::vector<Vertex*> selected_;
  std::vector<std::pair<Vertex*, Vertex*>> selected_edges_;
  uint8_t vertice_radius_;
  uint8_t last_hold = 0;
  uint8_t holded_id = 0;
};

#endif  // LOGIC_H
