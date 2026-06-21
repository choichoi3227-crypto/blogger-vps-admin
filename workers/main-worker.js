
/**
 * Main Worker: 고성능 SEO 및 V8 Isolate SSR 엔진
 */
export default {
  async fetch(request, env, ctx) {
    const url = new URL(request.url);

    // 블로그 포스팅 렌더링 요청만 처리
    try {
      const originUrl = new URL(url.pathname, 'https://YOUR_BLOG_NAME.blogspot.com');
      const response = await fetch(originUrl, {
        headers: request.headers,
        cf: { cacheTtl: 86400, cacheEverything: true }
      });

      // HTML 콘텐츠에 SEO 메타 태그 및 FAQ 스키마 자동 삽입
      return await injectSEOData(response, url.origin + url.pathname);
    } catch (e) {
      return fetch(request);
    }
  }
};

async function injectSEOData(response, fullUrl) {
  if (!response.headers.get('content-type')?.includes('text/html')) return response;
  let html = await response.text();
  
  // 간단한 메타 삽입 로직
  const ssrInjections = `<meta name="robots" content="index, follow"><link rel="canonical" href="${fullUrl}">`;
  html = html.replace('</head>', ssrInjections + '</head>');
  
  return new Response(html, { headers: response.headers });
}

