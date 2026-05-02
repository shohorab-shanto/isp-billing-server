{include file="sections/header.tpl"}
<h3>Bulk Recharge</h3>

<form method="post" action="{$_url}plan/bulk-recharge-post">
    <input type="hidden" name="csrf_token" value="{$csrf_token}">
    <input type="hidden" name="ids" value="{$ids|@implode:','}">

    <div class="form-group">
        <label>Select Plan</label>
        <select name="plan_id" class="form-control" required>
            <option value="">Select Plan</option>
            {foreach $plans as $p}
                <option value="{$p.id}">{$p.name_plan}</option>
            {/foreach}
        </select>
    </div>

    <div class="form-group">
        <label>Select Router</label>
        <select name="router_id" class="form-control" required>
            <option value="">Select Router</option>
            {foreach $routers as $r}
                <option value="{$r.id}">{$r.name}</option>
            {/foreach}
        </select>
    </div>

    <button type="submit" class="btn btn-primary">Recharge All</button>
</form>

{include file="sections/footer.tpl"}