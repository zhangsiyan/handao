<form action="/order" method="post" id="startyyue">
    <div class="Sh">
        <h2 class="t"><em><a href="/">&lt;首页</a></em>选择服务项目</h2>
        <h1 class="name">{{brands.name}} {{models.name}} 上门保养</h1>
        <p class="pre">价格：<span>￥0元</span></p>
        <input type="hidden" name="models_id" value="{{models.id}}">
        <p class="xm">项目：</p>
        <ul class="m">

            {% for cate in category %}
            <li>
                <p class="p1">
                    <label>
                        <input  checked="checked" onclick="ChePre();" type="checkbox" class="category"><span>{{cate.name}}</span>
                    </label>
                </p>

                <p class="p2">
                    <select name="products[]" onchange="check(this);" id="jiyou">
                        {% for row in product %}
                        {% if cate.id==row.category %}
                        <option value="{{row.member_price}}-{{row.id}}-{{cate.id}}-{{cate.name}}-{{row.name}}">{{row.name}}[￥{{row.member_price}}]</option>
                        {%endif%}
                        {% endfor %}
                    </select>
                </p>
            </li>
            {% endfor %}
        </ul>
        <p class="server">
            <label onclick="alert('服务费是必选项,无法取消！');return false;">
                <input name="server" value="{{fees}}" checked="checked" type="checkbox" readonly="readonly">
                <span>服务费￥{{fees}}元</span>
            </label>
        </p>

        <p class="other">
            其它：
            <label>
                <input name="other" id="qita" type="checkbox">
                <span>已有配件，仅购买上门服务</span>
            </label>
        </p>

        <p class="xia">
            <input value="下一步" id="btn_step2" type="submit">
        </p>
    </div>
</form>
<script type="text/javascript">

    var mleng = $('.Sh .m select').length;
    //计算价格
    function ChePre() {
        var pre = {{fees}};
        for (i = 0; i < mleng; i++) {
            var obj = $('.Sh .m select').eq(i);
            if ($('.Sh .m input').eq(i).attr('checked')) {
                var val = obj.val();
                if(val){
                    s = val.split("-");
                    pre += parseInt(s[0]);

                }

            }

        }
        $('.pre span').html('￥' + pre + '元');
    }
    ChePre();


    $("#btn_step2").click(function () {
         var a=  $('.category').is(':checked');
        $('.category').each(function(i,n){
            if (!$(this)[0].checked) {
               $(this).parent('label').parent('.p1').next().children('select').attr('name','');
            }else{
                $(this).parent('label').parent('.p1').next().children('select').attr('name','products[]');
            }
        })

        var p = "";
        var jiyou = $("#jiyou").val().split("-");
        p += "13:" + jiyou[0] + ",";
        var jilv = $("#jilv").val().split("-");
        p += "30:" + jilv[0] + ",";
        var kongqi = $("#kongqi").val().split("-");
        p += "58:" + kongqi[0] + ",";
        var kongtiao = $("#kongtiao").val().split("-");
        p += "60:" + kongtiao[0] + ",";

        if ($("#qita").is(':checked') == true) {
            p = "59:207";
        }
        else {
            p += "59:207";
        }

        if ("" == p) {
            alert("请选择预约项目!");
            return false;
        }
        $("#xm").val(p);

    });


    //下拉框值变的时候
    function check(obj) {
        if ($(obj).parent().prev().find('input').attr('checked') == false) {
            alert('请先取消掉已有配件，仅上门服务！');
            return false;
        }
        ChePre();
    }

    //仅上门服务的时候
    $('.Sh .other input').click(function () {
        if ($(this).attr('checked')) {
            $('.Sh .m input').removeAttr("checked");
        } else {
            $('.Sh .m input').attr('checked', 'checked');
        }
        ChePre();
    })
</script>
