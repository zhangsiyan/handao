<?php

class HdCmsArticle extends \Phalcon\Mvc\Model
{

    /**
     *
     * @var integer
     */
    public $id;

    /**
     * Initialize method for model.
     */
    public function initialize()
    {
        $this->hasMany('id', 'HdCmsArticleInChannel', 'article_id', array('alias' => 'HdCmsArticleInChannel'));
    }

    /**
     * Allows to query a set of records that match the specified conditions
     *
     * @param mixed $parameters
     * @return HdCmsArticle[]
     */
    public static function find($parameters = null)
    {
        return parent::find($parameters);
    }

    /**
     * Allows to query the first record that match the specified conditions
     *
     * @param mixed $parameters
     * @return HdCmsArticle
     */
    public static function findFirst($parameters = null)
    {
        return parent::findFirst($parameters);
    }

    /**
     * Returns table name mapped in the model.
     *
     * @return string
     */
    public function getSource()
    {
        return 'hd_cms_article';
    }

}
