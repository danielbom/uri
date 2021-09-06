// https://www.urionlinejudge.com.br/judge/en/problems/view/1195
#include <iostream>
#include <vector>

class Node
{
public:
  int value;
  Node *left = nullptr;
  Node *right = nullptr;

  Node(int x) : value(x) {}
};

class Tree
{
  Node *root = nullptr;

  Node *insert(Node *node, int value)
  {
    if (node == nullptr)
    {
      return new Node(value);
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
  void preOrder(std::vector<int> &xs, Node *node)
  {
    if (node != nullptr)
    {
      xs.push_back(node->value);
      this->preOrder(xs, node->left);
      this->preOrder(xs, node->right);
    }
  }
  void inOrder(std::vector<int> &xs, Node *node)
  {
    if (node != nullptr)
    {
      this->inOrder(xs, node->left);
      xs.push_back(node->value);
      this->inOrder(xs, node->right);
    }
  }
  void posOrder(std::vector<int> &xs, Node *node)
  {
    if (node != nullptr)
    {
      this->posOrder(xs, node->left);
      this->posOrder(xs, node->right);
      xs.push_back(node->value);
    }
  }

public:
  void insert(int value)
  {
    this->root = this->insert(this->root, value);
  }
  std::vector<int> preOrder()
  {
    std::vector<int> xs;
    this->preOrder(xs, this->root);
    return xs;
  }
  std::vector<int> inOrder()
  {
    std::vector<int> xs;
    this->inOrder(xs, this->root);
    return xs;
  }
  std::vector<int> posOrder()
  {
    std::vector<int> xs;
    this->posOrder(xs, this->root);
    return xs;
  }
};

void print_vector(std::vector<int> xs) {
  int n = xs.size();
  for (int i = 0; i < n; i++) {
    if (i != 0) std::cout << " ";
    std::cout << xs.at(i);
  }
  std::cout << std::endl;
}

int main()
{
  int cases, n, x, i, j;

  std::cin >> cases;

  for (i = 1; i <= cases; i++)
  {
    Tree root;
    std::cin >> n;
    for (j = 0; j < n; j++)
    {
      std::cin >> x;
      root.insert(x);
    }

    std::cout << "Case " << i << ":" << std::endl;
    std::cout << "Pre.: ";
    print_vector(root.preOrder());
    std::cout << "In..: ";
    print_vector(root.inOrder());
    std::cout << "Post: ";
    print_vector(root.posOrder());

    std::cout << std::endl;
  }

  return 0;
}
