#include "Button.h"
#include "Button.hpp"

Button::Button() : m_button_bridge(nullptr){}
Button::Button(void *parent, const bttn::property &prop) : Button::Button(){
    this->Create(parent, prop);
}

bool Button::Create(void *parent, const bttn::property &prop){
    if (this->m_button_bridge == nullptr){
        this->m_button_bridge = new ButtonBridge(parent, prop);
        return true;
    }
    return false;
}

ButtonBridge::ButtonBridge() : m_ns_view(nil), m_ns_button(nil), m_button_delegate([[ButtonDelegate alloc] init]){}
ButtonBridge::ButtonBridge(void *parent, const bttn::property &prop) : ButtonBridge::ButtonBridge(){
    this->Create(parent, prop);
}

ButtonBridge::~ButtonBridge(){
    if (this->m_ns_view != nil){
        [this->m_ns_button release];
    }
    [this->m_button_delegate release];
}

bool ButtonBridge::Create(void *parent, const bttn::property &prop){
    if (parent != nullptr){
        this->m_ns_view = (__bridge NSView*)parent;
        this->m_button_delegate.bridge = this;
        
        this->m_ns_button = [NSButton alloc];
        
        NSRect rect{};
        
        if (prop.point != visuals::default_position){
            rect.origin = CGPoint(prop.point.GetX(), prop.point.GetY());
        }else{
            rect.origin = CGPoint(0, 0);
        }
        
        if (prop.size != visuals::default_size){
            rect.size = CGSize(prop.size.GetX(), prop.size.GetY());
        }else{
            rect.size = [this->m_ns_button intrinsicContentSize];
        }
        
        [this->m_ns_button initWithFrame:rect];
        [this->m_ns_button setTitle: ((prop.title != nullptr) ? [NSString stringWithUTF8String:prop.title] : @"Button")];
        [this->m_ns_button setButtonType:(NSButtonType)prop.type];
        [this->m_ns_view addSubview:this->m_ns_button];
        
        return true;
    }
    return false;
}

@implementation ButtonDelegate

@end
