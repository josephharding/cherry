//
//  game.cpp
//  cherry
//
//  Created by Joseph Harding on 1/27/18.
//  Copyright © 2018 Joseph Harding. All rights reserved.
//

#include "game.h"
#include "glwrapper.h"

void on_surface_created()
{
    glClearColor(1.0f, 0.0f, 0.0f, 0.0f);
}

void on_surface_changed()
{
    // No-op
}

void on_touch(float x, float y)
{
    std::cout << "x: " << x << std::endl;
    //_verts.push_back(x);
}

void on_draw_frame()
{
    glClear(GL_COLOR_BUFFER_BIT);
}
