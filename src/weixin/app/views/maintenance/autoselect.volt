<div class="Hs">
    <h2 class="t"><em><a href="/">&lt;首页</a></em>选择型号</h2>
    <!--品牌-->
    <ul class="m">
        {% for row in a_z%}
        <li class="li" id="{{row}}">{{row}}</li>
        {% for brand in brands %}
        {% if brand.initials == row %}
        <li onclick="DataShow({{ brand.id }},this)">
            <p class="sp1"><img src="{{brand.logo_path}}"></p>

            <p class="sp2">{{ brand.name }}</p>
        </li>
        {% endif %}
        {% endfor %}
        {% endfor %}
    </ul>
    <!--品牌导航-->
    <div class="pk">
        <p class="p">
            {% for row in a_z %}<a href="#{{row}}">{{row}}</a>{% endfor %}
        </p>
    </div>

    <!--系列选择，系列下有型号-->
    {% for brand in brands %}
    <div class="Ms data{{ brand.id }}">
        <ul>
            {% for model in autoModel %}
            {% if brand.id==model.brands_id %}
            <li>
                <p class="p1">{{model.name}}</p>
                <ul class="u">
                    {% for exact in autoModelExact %}
                    {% if model.id==exact.models_id %}
                    <li>
                        <a href="/maintenance/serveselect?brands_id={{exact.brands_id}}&models_id={{exact.models_id}}&exact_id={{exact.id}}">{{exact.name}}</a>
                    </li>
                    {% endif %}
                    {% endfor%}
                </ul>
            </li>
            {% endif %}
            {% endfor%}
        </ul>
    </div>
    {% endfor%}

</div>
<script>
    //显示系列
    var ins = 0;
    function DataShow(classid, objs) {
        if (ins == 0) {
            $('.Hs .m').addClass('om');
        }
        $('.Hs .m li').css('border-left', '0px');
        $(objs).css('border-left', '3px solid #ff4400');
        var obj = '.data' + classid + '';
        $('.Ms').hide();
        $(obj).show();
    }

    //展开关闭型号
    $('.Ms .p1').click(function () {
        if ($(this).next().css('display') == 'block') {
            $(this).next().hide();
            $(this).removeClass('on');
            return false;
        }
        $('.Ms').find('.p1').removeClass('on');
        $(this).addClass('on');

        $('.Ms').find('.u').hide();
        $(this).next().show();
    })
</script>
