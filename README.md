# Overview

This assignment consists of a single screen where a user can search movies by typing keywords. It has been written in swift 4 for iPhone devices with minimum support for iOS 9. The user interface of the app is designed in auto layout.

# Dependency

This app additionally depends on following open source libraries.
* [SDWebImage](https://github.com/rs/SDWebImage) - For async image loading and caching
* [UIScrollView-InfiniteScroll](https://github.com/pronebird/UIScrollView-InfiniteScroll) - For pagination support

# Architecture

The architecture of the app is MVVM (Model-View-ViewModel) with two additional layers for networking and persistence.

## Model

The models are implemented as data only structs. The models defining API responses implement `Decodable` protocol for mapping response data to swift structs.

## View

The view controllers and storyboards are considered parts of this layer. The responsibility of this layer is only the presentation of data to user and receiving events from user.

## ViewModel

The view models contain business logic of a view. Preparing data for presentation and handling user events are responsibilities of this layer.

A view model knows nothing about a view but emits events which a view observes to present data accordingly. The event listening is done in a single block providing event enum value. The primary reason for using a single callback is to reduce the possibility of infamous retain cycles.

## Network

This layer is responsible for executing web requests and providing response in asynchronous way. There is a `APIClient` protocol which expects the execution of a request. Its implementation is built on `URLSession`, but can be easily changed to any other networking library. The `APIOperation` protocol represents an executable api operation. So there would be a separate struct for each api endpoint.

## Persistence

This layer is responsible for persisting data based on repository pattern. So there would be a separate repository class for each different kind of entity.
