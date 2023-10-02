<?php
namespace wcf\system\box;
use wcf\system\WCF;

/**
 * Box that shows a donation button.
 * 
 */
class DonationBoxController extends AbstractBoxController {
	/**
	 * @inheritDoc
	 */
	protected static $supportedPositions = ['sidebarLeft', 'sidebarRight'];
	
	/**
	 * @inheritDoc
	 */
	protected function loadContent() {
		$this->content = WCF::getTPL()->fetch('boxDonationBox', 'wcf', [], true);
	}
}
