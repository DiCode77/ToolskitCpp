//
//  Point.hpp
//  ToolsKitCpp
//
//  Created by DiCode77.
//

#ifndef Point_hpp
#define Point_hpp

namespace visuals{
struct Points{
    double x = 0.f;
    double y = 0.f;
};

class point{
    Points m_coord;
public:
    point() = default;
    point(double _x, double _y) : m_coord(_x, _y){}
    point(const point &parent) : m_coord(parent.m_coord.x, parent.m_coord.y){}
    
    bool operator== (const point &point) const{
        return this->m_coord.x == point.m_coord.x && this->m_coord.y == point.m_coord.y;
    }
    
    bool operator!= (const point &point) const{
        return this->m_coord.x != point.m_coord.x && this->m_coord.y != point.m_coord.y;
    }
    
    double GetX() const{
        return this->m_coord.x;
    }
    
    double GetY() const{
        return this->m_coord.y;
    }
};

};

#endif
