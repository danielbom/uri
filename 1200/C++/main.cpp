// https://www.urionlinejudge.com.br/judge/en/problems/view/1195
#include <iostream>
#include <vector>
#include <string>

template <typename T>
class Node
{
public:
  T value;
  Node *left = nullptr;
  Node *right = nullptr;

  Node(T x) : value(x) {}
};

template <typename T>
class Tree
{
  Node<T> *root = nullptr;

  Node<T> *insert(Node<T> *node, int value)
  {
    if (node == nullptr)
    {
      return new Node<T>(value);
    }
    else
    {
      if (value < node->value)
      {
        node->left = this->insert(node->left, value);
      }
      else if (value > node->value)
      {
        node->right = this->insert(node->right, value);
      }
    }
    return node;
  }
  void preOrder(std::vector<T> &xs, Node<T> *node)
  {
    if (node != nullptr)
    {
      xs.push_back(node->value);
      this->preOrder(xs, node->left);
      this->preOrder(xs, node->right);
    }
  }
  void inOrder(std::vector<T> &xs, Node<T> *node)
  {
    if (node != nullptr)
    {
      this->inOrder(xs, node->left);
      xs.push_back(node->value);
      this->inOrder(xs, node->right);
    }
  }
  void posOrder(std::vector<T> &xs, Node<T> *node)
  {
    if (node != nullptr)
    {
      this->posOrder(xs, node->left);
      this->posOrder(xs, node->right);
      xs.push_back(node->value);
    }
  }

  bool includes(Node<T> *node, T &value)
  {
    if (node == nullptr)
      return false;
    else
    {
      if (value < node->value)
        return this->includes(node->left, value);
      if (value > node->value)
        return this->includes(node->right, value);
      return true;
    }
  }

public:
  void insert(int value)
  {
    this->root = this->insert(this->root, value);
  }
  std::vector<T> preOrder()
  {
    std::vector<T> xs;
    this->preOrder(xs, this->root);
    return xs;
  }
  std::vector<T> inOrder()
  {
    std::vector<T> xs;
    this->inOrder(xs, this->root);
    return xs;
  }
  std::vector<T> posOrder()
  {
    std::vector<T> xs;
    this->posOrder(xs, this->root);
    return xs;
  }

  bool includes(T &value)
  {
    return this->includes(this->root, value);
  }
};

template <typename T>
void print_vector(std::vector<T> xs)
{
  int n = xs.size();
  for (int i = 0; i < n; i++)
  {
    if (i != 0)
      std::cout << " ";
    std::cout << xs.at(i);
  }
  std::cout << std::endl;
}

int main()
{
  Tree<char> root;
  std::string line;
  int n;
  do
  {
    std::getline(std::cin, line);
    n = line.size();
    if (line == "INFIXA")
      print_vector(root.inOrder());
    else if (line == "PREFIXA")
      print_vector(root.preOrder());
    else if (line == "POSFIXA")
      print_vector(root.posOrder());
    else if (n > 0)
    {
      switch (line.at(0))
      {
      case 'I':
        root.insert(line.at(2));
        break;
      case 'P':
        if (root.includes(line.at(2)))
          std::cout << line.at(2) << " existe" << std::endl;
        else 
          std::cout << line.at(2) << " nao existe" << std::endl;
      }
    }
  } while (n > 0);
}
