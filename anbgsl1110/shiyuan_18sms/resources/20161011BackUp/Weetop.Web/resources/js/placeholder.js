/**
 * 兼容IE6的placeholder
 */
 $(function () {
	fnPlaceholder()
});
	var fnPlaceholder = function () {
	if (!('placeholder' in document.createElement('input'))) {/* nonsupport placeholder*/
		$("input[placeholder],textarea[placeholder]").closest('form').has(':reset').bind('reset', function () {/*click reset*/
        	setTimeout(function () {
            	$("input[placeholder],textarea[placeholder]").each(function () {
                	$(this).val($(this).attr('placeholder')).addClass('ie-placeholder');
                });
            }, 0)

        });
        $("input[placeholder],textarea[placeholder]").each(function () {
        	$(this).val($(this).attr('placeholder')).addClass('ie-placeholder');
        }).bind('focus', function () {
        	if ($(this).val() == $(this).attr('placeholder')) {
            	$(this).val("").removeClass('ie-placeholder')
            }
        }).bind('blur', function () {
        if ($(this).val().length == 0) {
			$(this).val($(this).attr('placeholder')).addClass('ie-placeholder')
			}
		 })
	}
	$("input:submit").click(function(){
		$(this).parents("form").find("input[placeholder],textarea[placeholder]").each(function(){
			if ($(this).val() == $(this).attr('placeholder')) {
            	$(this).val("").removeClass('ie-placeholder');
            	return false;
            }
		})
	})
 }