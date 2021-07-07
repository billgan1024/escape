//remember that arrays are passed by reference but if ur changing this array
//it gets copied
function arraySort(array, ascend)
{
    var list = ds_list_create();
    var count = array_length(array);
    for (var i=0; i<count; i++) list[| i] = array[i];
    ds_list_sort(list, ascend);
    for (i=0; i<count; i++) array[i] = list[| i];
    ds_list_destroy(list);
    return array;
}
