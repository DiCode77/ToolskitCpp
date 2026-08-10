//
//  Size.hpp
//  ToolsKitCpp
//
//  Created by DiCode77.
//

#ifndef Size_hpp
#define Size_hpp

#include "Point.hpp"

namespace visuals{
class size{
    Points m_coord;
public:
    size() = default;
    size(double _x, double _y) : m_coord(_x, _y){}
    size(const size &parent) : m_coord(parent.m_coord.x, parent.m_coord.y){}
    
    bool operator== (const size &point) const{
        return this->m_coord.x == point.m_coord.x && this->m_coord.y == point.m_coord.y;
    }
    
    bool operator!= (const size &point) const{
        return this->m_coord.x != point.m_coord.x && this->m_coord.y != point.m_coord.y;
    }
    
    double GetX() const{
        return this->m_coord.x;
    }
    
    double GetY() const{
        return this->m_coord.y;
    }
};

const size default_size = size(90, 20);
};

#endif
