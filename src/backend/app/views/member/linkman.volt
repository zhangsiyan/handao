<h2 class="sub-header">联系人</h2>
<div class="table-responsive">
    <a href="/member/list" class="btn btn-primary">返回</a>
    <table class="table table-striped">
        <thead>
        <tr>
            <th>ID</th>
            <th>姓名</th>
            <th>手机号</th>
        </tr>
        </thead>
        <tbody>
        {% for row in page.items %}
        <tr>
            <td>{{row.id}}</td>
            <td>{{row.name}}</td>
            <td>{{row.mobile}}</td>
            <td>编辑</td>
        </tr>
        {% endfor %}
        </tbody>

    </table>
</div>


