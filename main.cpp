#include <iostream>
#include <fstream>

using namespace std;

int updateNum;
int number;
std::ofstream outfile ("Priemgetallen.txt");

int update()
{
    if(number != 2 && (number%2==0) || number != 3 &&(number%3==0) || (number%4==0)||number != 5 &&(number%5==0)||(number%6==0)|| number != 7 && (number%7==0)||(number%8==0)||(number%9==0))
    {
         outfile << number << "   NOPE" << std::endl;
    }
    else if((number/1==number) && (number/number==1))
    {
        outfile << number << "   PRIEMGETAL" << std::endl;
    }
        number += 1;
}

int main()
{
    number = 2;

    while(number <= 1000)
    {
        update();

    }

}
