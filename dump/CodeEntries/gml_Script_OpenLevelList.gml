if (argument0)
{
    level_stat = 0;
}
else
{
    ini_open("S");
    for (var i = 0; i < max_levels; i++)
    {
        level_stat[i] = ini_read_real("LEV", "L" + string(i), 0);
    }
    if (level_stat[0] == 0)
    {
        level_stat[0] = 1;
    }
    ini_close();
}
