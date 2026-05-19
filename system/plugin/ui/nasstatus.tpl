{include file="sections/header.tpl"}

<div class="row">
    <div class="col-sm-12">
        <div class="panel panel-hovered mb20 panel-primary">

            <div class="panel-heading">
                <span>
                    NAS Status: {$onlineCount} Online / {$offlineCount} Offline
                </span>

                <!-- Refresh Button -->
                <a href="{$_url}plugin/nas_status" class="btn btn-sm btn-primary pull-right">
                    Refresh
                </a>
            </div>

            <div class="table-responsive">
                <table class="table table-bordered table-striped">
                    <thead>
                        <tr>
                            <th>{Lang::T('Number')}</th>
                            <th>{Lang::T('Location')}</th>
                            <th>{Lang::T('NAS IP Address')}</th>
                            <th>{Lang::T('Status')}</th>
                        </tr>
                    </thead>

                    <tbody>
                        {$no = 1}

                        {if $nasData|@count > 0}
                            {foreach from=$nasData item=nas}
                                <tr>
                                    <td>{$no++}</td>
                                    <td>{$nas.shortname}</td>
                                    <td>{$nas.nasname}</td>

                                    <td>
                                        {if $nas.status == 'online'}
                                            <span class="label label-success">
                                                {Lang::T('Online')}
                                            </span>
                                        {else}
                                            <span class="label label-danger">
                                                {Lang::T('Offline')}
                                            </span>
                                        {/if}
                                    </td>
                                </tr>
                            {/foreach}
                        {else}
                            <tr>
                                <td colspan="4" class="text-center">
                                    No NAS Found
                                </td>
                            </tr>
                        {/if}

                    </tbody>
                </table>
            </div>

        </div>
    </div>
</div>

{include file="sections/footer.tpl"}
