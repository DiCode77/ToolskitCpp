//
//  Button.hpp
//  ToolsKitCpp
//
//  Created by DiCode77.
//

#ifndef ButtonBridge_hpp
#define ButtonBridge_hpp

#include <Foundation/Foundation.h>
#include <Cocoa/Cocoa.h>
#include <functional>
#include <set>
#include <filesystem>

#include "Point.hpp"
#include "Size.hpp"

#include "PropertyButton.hpp"

class ButtonBridge;
@interface ButtonDelegate : NSObject
@property (nonatomic, assign) ButtonBridge *bridge;
- (void)buttonClicked:(id)sender;
@end

class ButtonBridge{
    NSView         *m_ns_view;
    NSButton       *m_ns_button;
    ButtonDelegate *m_button_delegate;
public:
    std::function<void(const bttn::event&)> m_cell_button;
    std::set<NSButton*>                     m_array_button;
public:
    ButtonBridge();
    ButtonBridge(void*, const bttn::property&);
    ~ButtonBridge();
    
    void set_title(const char*);
    const char *get_title();
    
    void set_size(const visuals::size&);
    void set_position(const visuals::point&);
    
    visuals::size  get_size() const; 
    visuals::point get_position() const;
    
    bool is_enabled() const;
    bool is_hidden() const;
    bool is_bordered() const;
    bttn::state is_state() const;
    
    void set_enabled(bool);
    void set_hidden(bool);
    void set_bordered(bool);
    void set_state(const bttn::state&);
    
    void set_toggle(ButtonBridge *l_bbuton);
    void remove_toggle(ButtonBridge *l_bbuton);
    
    bool is_image();
    void set_image(const bttn::img&);
    void remove_image();
    
    void set_bezel_color(const bttn::colors&);
    
    bool Create(void*, const bttn::property&);
    void _bind(const std::function<void(const bttn::event&)>&);
private:
    NSImage *init_image_in_button(const bttn::img&);
};

#endif
