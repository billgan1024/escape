t1 = ds_map_create();
t1[?"enemies"] = [{x: 2, y: 3}, {x: 3, y: 4}];
// log(game_get_speed(gamespeed_fps));
// log(sha512("bruh moment"));
// var file = get_save_filename_ext("*.dat", "", "", "Open a saved level");
json = "{\"myObj\": { \"apples\":10, \"oranges\":12, \"potatoes\":100000, \"avocados\":0 }, \"myArray\":[0, 1, 2, 2, 4, 0, 1, 5, 1]}";
data = json_parse(json);
arr = array_create(16, {});
log(arr);
if variable_struct_exists(data, "myObj")
{
if is_struct(data.myObj)
    {
    var _names = variable_struct_get_names(data.myObj);
    var _str = "";
    for (var i = 0; i < array_length(_names); i++;)
        {
        _str = _names[i] + ": " + string(variable_struct_get(data.myObj, _names[i]));
        show_debug_message(_str);
        }
    }
if variable_struct_exists(data, "myArray")
    {
    if is_array(data.myArray)
        {
        show_debug_message(data.myArray);
        }
    }
}