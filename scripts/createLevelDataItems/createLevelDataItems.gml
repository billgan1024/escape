//edit level data for a particular level. if you are editing an existing level, then
//the name will automatically be set
function createLevelDataItems(lvlName) {
    
    #region level name
    with(instance_create_layer(vw/2, 400, "Persistent", oTextBox)) {
        label = "Level Name";
        text = lvlName;
    }
    #endregion
    
    #region play, edit, publish, and delete levels
    #endregion
    
    #region back
    #endregion
}