// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import ChangeClassController from "./change_class_controller"
application.register("change-class", ChangeClassController)

import DragController from "./drag_controller"
application.register("drag", DragController)

import MapController from "./map_controller"
application.register("map", MapController)

import PopoverController from "./popover_controller"
application.register("popover", PopoverController)

import TypedJsController from "./typed_js_controller"
application.register("typed-js", TypedJsController)
