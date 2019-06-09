#ifndef STATISTIC_H
#define STATISTIC_H
#include <vector>
#include <numeric>
#include <cmath>
#include <algorithm>

template<class T> class Statistics {
public:
    Statistics(std::vector<T> _data) {
        data = _data;
        size = _data.size();
    }
    double getMean() {
        return std::accumulate(data.begin(), data.end(), .0) / size;
    }
    double getVariance() {
        double mean = getMean();
        double temp = 0;
        for(double a :data)
            temp += (a-mean)*(a-mean);
        return temp/(size-1);
    }
    double getStdDev() {
        return std::pow(getVariance(), 0.5);
    }
    double median() {
       std::sort(data.begin(),data.end());
       if (data.size() % 2 == 0)
          return (data[(data.size() / 2) - 1] + data[data.size()/ 2]) / 2.0;
       return data[data.size() / 2];
    }
    private:
        std::vector<T> data;
        int size;
};


#endif // STATISTIC_H
