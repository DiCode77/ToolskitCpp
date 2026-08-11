#include "Button.h"
#include "Button.hpp"

Button::Button() : m_button_bridge(nullptr){}
Button::Button(void *parent, const bttn::property &prop) : Button::Button(){
    this->Create(parent, prop);
}

void Button::set_title(const char *title){
    if (this->m_button_bridge != nullptr){
        this->m_button_bridge->set_title(title);
    }
}

const char *Button::get_title(){
    if (this->m_button_bridge != nullptr){
        this->m_button_bridge->get_title();
    }
    return "";
}

void Button::set_size(const visuals::size &size){
    if (this->m_button_bridge != nullptr){
        this->m_button_bridge->set_size(size);
    }
}

void Button::set_position(const visuals::point &point){
    if (this->m_button_bridge != nullptr){
        this->m_button_bridge->set_position(point);
    }
}

visuals::size Button::get_size() const{
    if (this->m_button_bridge != nullptr){
        return this->m_button_bridge->get_size();
    }
    return {};
}

visuals::point Button::get_position() const{
    if (this->m_button_bridge != nullptr){
        return this->m_button_bridge->get_position();
    }
    return {};
}

bool Button::is_enabled() const{
    if (this->m_button_bridge != nullptr){
        return this->m_button_bridge->is_enabled();
    }
    return false;
}

bool Button::is_hidden() const{
    if (this->m_button_bridge != nullptr){
        return this->m_button_bridge->is_hidden();
    }
    return false;
}

bool Button::is_bordered() const{
    if (this->m_button_bridge != nullptr){
        return this->m_button_bridge->is_bordered();
    }
    return false;
}

bttn::state Button::is_state() const{
    if (this->m_button_bridge != nullptr){
        return this->m_button_bridge->is_state();
    }
    return {};
}

void Button::set_enabled(bool status){
    if (this->m_button_bridge != nullptr){
        this->m_button_bridge->set_enabled(status);
    }
}

void Button::set_hidden(bool status){
    if (this->m_button_bridge != nullptr){
        this->m_button_bridge->set_hidden(status);
    }
}

void Button::set_bordered(bool status){
    if (this->m_button_bridge != nullptr){
        this->m_button_bridge->set_bordered(status);
    }
}

bool Button::Create(void *parent, const bttn::property &prop){
    if (this->m_button_bridge == nullptr){
        this->m_button_bridge = new ButtonBridge(parent, prop);
        return true;
    }
    return false;
}

void Button::bind(const std::function<void(const bttn::event&)> &func){
    this->m_button_bridge->_bind(func);
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

void ButtonBridge::set_title(const char *title){
    if (this->m_ns_button != nil){
        [this->m_ns_button setTitle:((title != nullptr) ? [NSString stringWithUTF8String:title] : @"")];
    }
}

const char *ButtonBridge::get_title(){
    if (this->m_ns_button != nil){
        return [[this->m_ns_button title] UTF8String];
    }
    return "";
}

void ButtonBridge::set_size(const visuals::size &size){
    if (this->m_ns_button != nil){
        NSRect rect = this->m_ns_button.frame;
        rect.size = NSMakeSize((CGFloat)size.GetX(), (CGFloat)size.GetY());
        this->m_ns_button.frame = rect;
    }
    return;
}

void ButtonBridge::set_position(const visuals::point &point){
    if (this->m_ns_button != nil){
        NSRect rect = this->m_ns_button.frame;
        rect.origin = NSMakePoint((CGFloat)point.GetX(), (CGFloat)point.GetY());
        this->m_ns_button.frame = rect;
    }
    return;
}

visuals::size ButtonBridge::get_size() const{
    if (this->m_ns_button != nil){
        CGSize size = [this->m_ns_button frame].size;
        return { static_cast<double>(size.width), static_cast<double>(size.height) };
    }
    return {};
}

visuals::point ButtonBridge::get_position() const{
    if (this->m_ns_button != nil){
        CGPoint point = [this->m_ns_button frame].origin;
        return { static_cast<double>(point.x), static_cast<double>(point.y) };
    }
    return {};
}

bool ButtonBridge::is_enabled() const{
    if (this->m_ns_button != nil){
        return static_cast<bool>([this->m_ns_button isEnabled]);
    }
    return false;
}

bool ButtonBridge::is_hidden() const{
    if (this->m_ns_button != nil){
        return static_cast<bool>([this->m_ns_button isHidden]);
    }
    return false;
}

bool ButtonBridge::is_bordered() const{
    if (this->m_ns_button != nil){
        return static_cast<bool>([this->m_ns_button isBordered]);
    }
    return false;
}

bttn::state ButtonBridge::is_state() const{
    if (this->m_ns_button != nil){
        return static_cast<bttn::state>([this->m_ns_button state]);
    }
    return {};
}

void ButtonBridge::set_enabled(bool en){
    if (this->m_ns_button != nil){
        [this->m_ns_button setEnabled:(BOOL)en];
    }
    return;
}

void ButtonBridge::set_hidden(bool en){
    if (this->m_ns_button != nil){
        [this->m_ns_button setHidden:(BOOL)en];
    }
    return;
}

void ButtonBridge::set_bordered(bool en){
    if (this->m_ns_button != nil){
        [this->m_ns_button setBordered:en];
    }
    return;
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
            rect.size = CGSize(visuals::default_size.GetX(), visuals::default_size.GetY());
        }
        
        [this->m_ns_button initWithFrame:rect];
        [this->m_ns_button setTitle: ((prop.title != nullptr) ? [NSString stringWithUTF8String:prop.title] : @"Button")];
        [this->m_ns_button setState:(NSControlStateValue)prop.state];
        [this->m_ns_button setBezelStyle:(NSBezelStyle)prop.style];
        [this->m_ns_button setButtonType:(NSButtonType)prop.type];
        [this->m_ns_button setBordered:(BOOL)prop.bordered];
        [this->m_ns_view addSubview:this->m_ns_button];
        
        return true;
    }
    return false;
}

void ButtonBridge::_bind(const std::function<void(const bttn::event&)> &func){
    if (this->m_ns_button){
        [this->m_ns_button setTarget:this->m_button_delegate];
        [this->m_ns_button setAction:@selector(buttonClicked:)];
        this->m_cell_button = std::move(func);
    }
}

@implementation ButtonDelegate
- (void)buttonClicked:(id)sender{
    if (self.bridge != nullptr){
        if (self.bridge->m_cell_button){
            NSButton *button = (NSButton*)sender;
            bttn::event ev{
                .prop{
                    .title  = [[button title] UTF8String],
                    .point{
                        static_cast<double>([button frame].origin.x),
                        static_cast<double>([button frame].origin.y)
                    },
                        .size{
                            static_cast<double>([button frame].size.width),
                            static_cast<double>([button frame].size.height)
                        },
                    .type   = static_cast<bttn::btype>(-1),
                    .style  = static_cast<bttn::bstyle>([button bezelStyle]),
                    .state  = static_cast<bttn::state>([button state]),
                },
                    .enabled = static_cast<bool>([button isEnabled]),
                .hidden = static_cast<bool>([button isHidden]),
            };
            self.bridge->m_cell_button(ev);
        }
    }
}
@end
