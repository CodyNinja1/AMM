bool EnableMixMapping = false;
bool EnableAirMapping = false;

void Main() 
{  
    while (true) { // this is ok as long as we use yield();
        EnableMapping(EnableMixMapping, EnableAirMapping);
        yield();
    }
}

void EnableMapping(bool EnableMixMapping, bool EnableAirMapping)
{
    CGameCtnEditorCommon@ editor = cast<CGameCtnEditorFree>(GetApp().Editor); // cast editor into CGameCtnEditorCommon type variable
    if (editor !is null) // Quickly check if we can apply the patch, otherwise just don't do anything
    // do not use == when checking if a variable is null, use "is" instead (ty miss)
    {
        if (Setting_Mixmapping)
        {
        editor.EnableGhostMode = EnableMixMapping;
        }

        if (Setting_Airmapping)
        {
        editor.UseNewPillars = EnableAirMapping;
        }
    }
}

void RenderMenu() {
    if (Setting_Mixmapping)
    {
        //                      Red Color      Icon                       Text                        Show current keybinds       Show Status
        if (UI::MenuItem("\\$F55" + Icons::Pencil + "\\$z Always Enable Mixmapping", tostring(Setting_ShortcutMix), EnableMixMapping)) 
        {
            EnableMixMapping = !EnableMixMapping;
        }
    }
    if (Setting_Airmapping)
    {
        //                     Yellow Color     Icon                      Text                       Show current keybinds       Show Status
        if (UI::MenuItem("\\$FD1" + Icons::Pencil + "\\$z Always Enable Airmapping", tostring(Setting_ShortcutAir), EnableAirMapping)) 
        {
            EnableAirMapping = !EnableAirMapping;
        }
    }
}

bool CheckKeys(VirtualKey key)
{
    CGameCtnEditorCommon@ editor = cast<CGameCtnEditorFree>(GetApp().Editor);
    if (editor is null) // do not use == when checking if a variable is null, use "is" instead (ty miss)
    return false; // Quickly check if we are in the map editor, otherwise ignore keypresses

    if (key == Setting_ShortcutMix) 
    {
        // print("Mixmapping Shortcut!");
        EnableMixMapping = !EnableMixMapping;
        return true;
    }
    if (key == Setting_ShortcutAir) 
    {
        // print("Airmapping Shortcut!");
        EnableAirMapping = !EnableAirMapping;
        return true;
    }
    return false;
}

UI::InputBlocking OnKeyPress(bool down, VirtualKey key) 
{
    if (down && CheckKeys(key)) 
    {
        return UI::InputBlocking::DoNothing;
    }
    return UI::InputBlocking::DoNothing;
}
