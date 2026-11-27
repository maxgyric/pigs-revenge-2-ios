if (!is_win)
{
    var quest_text = "";
    switch (quest_id)
    {
        case 0:
            quest_text = "Kill " + string(quest_v[0]) + " enemies!";
            break;
        case 1:
            quest_text = "Kill BOSS";
            break;
        case 2:
            quest_text = "Survive " + string(ceil(quest_v[0] - battle_time)) + " seconds!";
            break;
    }
    var pa = draw_get_alpha();
    draw_set_alpha(draw_get_alpha() * 0.5);
    DT(CW, 80 * A, quest_text, 1);
    draw_set_alpha(pa);
}
