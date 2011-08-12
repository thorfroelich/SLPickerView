The UIPickerView subclass contained in this project allows touch events that would otherwise get trapped by the picker to be forwarded to the picker's superview.

It is useful for creating a pickerview that only makes a selection when the user taps an entry and not when an entry scrolls past the center indicator area, which is the default UIPickerView behaviour. For instance it can be used to reproduce behaviour similar to the one Mobile Safari displays when interacting with a dropdown menu.

Thor Frølich
[Strange Loop](http://strangeloop.dk)