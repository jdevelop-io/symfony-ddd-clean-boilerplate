<?php

use SymfonyCleanBoilerplate\Web\App\Kernel;

require_once dirname(__DIR__) . '/vendor/autoload_runtime.php';

return static function (array $context): Kernel {
    if (!isset($context['APP_ENV']) || !is_string($context['APP_ENV'])) {
        throw new LogicException('The APP_ENV environment variable must be set.');
    }

    return new Kernel($context['APP_ENV'], (bool)$context['APP_DEBUG']);
};
